using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;
using System.IO;
using Microsoft.Office.Tools;
using Microsoft.Office.Interop;
using System.Data.OleDb;
using System.Data;
using System.Transactions;

namespace EducationManager.Controllers
{
    public class studentController : Controller
    {
        //
        // GET: /student/

        public ActionResult StudentList()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            DBDataContext db = new DBDataContext();
            List<student> list = (from a in db.student select a).ToList();
            List<classes> cllist = (from a in db.classes select a).Distinct().ToList();
            List<SelectListItem> itemlist = new List<SelectListItem>();
            foreach (var item in cllist)
            {
                itemlist.Add(new SelectListItem() { Text = item.cl_name, Value = item.cl_id.ToString() });
            }
            ViewData["cl"] = itemlist;
            return View(list);
        }
        /// <summary>
        /// 搜索查询
        /// </summary>
        /// <param name="num">学号</param>
        /// <param name="name">姓名</param>
        /// <param name="tel">电话</param>
        /// <param name="cid">身份证号</param>
        /// <param name="cl">班级</param>
        /// <returns></returns>
        public ActionResult SearchInfo(string num, string name, string cid, string cl)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                if (num == null)
                {
                    num = "";
                }
                if (name == null)
                {
                    name = "";
                }

                if (cid == null)
                {
                    cid = "";
                }
                DBDataContext db = new DBDataContext();
                IEnumerable<student> list = from a in db.student where a.stu_name.Contains(name.Trim()) && a.stu_num.ToString().Contains(num.Trim()) && a.stu_cid.Contains(cid.Trim()) select a;

                if (cl != "" && cl != null)
                {
                    list = list.Where(a => a.stu_clid == Convert.ToInt32(cl));
                }
                string contentstr = "<table class='table table-hover'>  <caption>学生信息</caption><tr> <th>学号</th><th>姓名</th><th class='hidden-xs'>身份证号</th><th>电话</th><th>班级</th><th class='hidden-xs'>入学日期</th><th class='hidden-xs'>毕业高中</th><th class='hidden-xs'>操作</th></tr>";
                if (list.Count() <= 0)
                {
                    contentstr += "<td colspan='15' style='text-align:center;color:red;font-size:22px;'>没有符合您查找条件的内容</td>";
                }
                foreach (var item in list)
                {
                    contentstr += "<tr><td>" + item.stu_num + "</td><td>" + item.stu_name + "</td><td class='hidden-xs'>" + item.stu_cid + "</td><td>" + item.stu_tel + "</td><td>" + item.classes.cl_name + "</td><td class='hidden-xs'>" + item.stu_joinTime + "</td><td class='hidden-xs'>" + item.stu_highSchool + "</td><td class='hidden-xs'><a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px;' href='/student/studentInfo/" + item.stu_num + "' data-target='#editmodal'>查看详情</a> <a data-toggle='modal' class='btn btn-primary' style='height: 30px; padding: 2px 12px; background-color: #666666;border-color: #666666;' href='/student/Delete/" + item.stu_num + "' data-target='#delmodal'>删除</a></td>";
                }
                contentstr += "</table>";
                return Content(contentstr);
            }
            catch
            {
                return View();
            }
        }
        /// <summary>
        /// 下载指定格式模板
        /// </summary>
        [HttpPost]
        public void DownloadFile()
        {
            string fileName = "studentInfoTemplate.xlsx";
            string fPath = "/Content/files/"+fileName;
            string filePath = Server.MapPath(fPath);//路径
            //以字符流的形式下载文件
            FileStream fs = new FileStream(filePath, FileMode.Open);
            byte[] bytes = new byte[(int)fs.Length];
            fs.Read(bytes, 0, bytes.Length);
            fs.Close();
            Response.ContentType = "application/octet-stream";
            //通知浏览器下载文件而不是打开
            Response.AddHeader("Content-Disposition", "attachment;   filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
            Response.BinaryWrite(bytes);
            Response.Flush();
            Response.End();
        }
        /// <summary>
        /// 批量导入学生信息
        /// </summary>
        /// <returns></returns>
        public ActionResult AddInfos()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            return View();
        }
        [HttpPost]
        public ActionResult AddInfos(HttpPostedFileBase filebase)
        {
            HttpPostedFileBase file = Request.Files["files"];
            string FileName;
            string savePath;
            if (file == null || file.ContentLength <= 0)
            {
                //ViewBag.error = "文件不能为空";
                return View();
            }
            else
            {
                string filename = Path.GetFileName(file.FileName);
                int filesize = file.ContentLength;//获取上传文件的大小单位为字节byte
                string fileEx = System.IO.Path.GetExtension(filename);//获取上传文件的扩展名
                string NoFileName = System.IO.Path.GetFileNameWithoutExtension(filename);//获取无扩展名的文件名
                int Maxsize = 4000 * 1024;//定义上传文件的最大空间大小为4M
                string FileType = ".xls,.xlsx";//定义上传文件的类型字符串

                FileName = NoFileName + DateTime.Now.ToString("yyyyMMddhhmmss") + fileEx;
                if (!FileType.Contains(fileEx))
                {
                    // ViewBag.error = "文件类型不对，只能导入xls和xlsx格式的文件";
                    return View();
                }
                if (filesize >= Maxsize)
                {
                    // ViewBag.error = "上传文件超过4M，不能上传";
                    return View();
                }
                string path = AppDomain.CurrentDomain.BaseDirectory + "Content/uploads/excel/";
                if (!Directory.Exists(path))//如果文件不存在就创建
                {
                    Directory.CreateDirectory(path);
                }
                savePath = Path.Combine(path, FileName);

                file.SaveAs(savePath);
            }

            string strConn;
            strConn = "Provider=Microsoft.Ace.OleDb.12.0;" + "data source=" + savePath + ";Extended Properties='Excel 12.0; HDR=yes; IMEX=0'";
            OleDbConnection conn = new OleDbConnection(strConn);
            conn.Open();
            OleDbDataAdapter myCommand = new OleDbDataAdapter("select * from [Sheet1$]", strConn);
            DataSet myDataSet = new DataSet();
            try
            {
                myCommand.Fill(myDataSet, "ExcelInfo");
            }
            catch (Exception ex)
            {
                return View();
            }
            DataTable table = myDataSet.Tables["ExcelInfo"].DefaultView.ToTable();

            //引用事务机制，出错时，事物回滚
            using (TransactionScope transaction = new TransactionScope())
            {
                for (int i = 0; i < table.Rows.Count - 1; i++)
                {
                    //获取地区名称
                    string _areaName = table.Rows[i][0].ToString();
                    //判断地区是否存在
                    DBDataContext db = new DBDataContext();
                    student stu = new student();
                    stu.stu_password = "123456";
                    stu.stu_name = table.Rows[i][0].ToString();
                    stu.stu_sex = table.Rows[i][1].ToString();
                    stu.stu_birth = Convert.ToDateTime(table.Rows[i][2].ToString());
                    stu.stu_nation = table.Rows[i][3].ToString();
                    stu.stu_cid = table.Rows[i][4].ToString();
                    stu.stu_tel = table.Rows[i][5].ToString();
                    stu.stu_address = table.Rows[i][6].ToString();
                    classes cl = (from a in db.classes where a.cl_name == table.Rows[i][7].ToString().Trim() select a).First();
                    stu.stu_clid = cl.cl_id;//班级编号
                    stu.stu_politicalOutlook = table.Rows[i][8].ToString();
                    stu.stu_joinTime = Convert.ToDateTime(table.Rows[i][9].ToString());
                    stu.stu_highSchool = table.Rows[i][10].ToString();
                    stu.stu_remark = table.Rows[i][11].ToString();
                    db.student.InsertOnSubmit(stu);
                    db.SubmitChanges();
                }
                transaction.Complete();
            }
            System.Threading.Thread.Sleep(2000);
            return RedirectToAction("StudentList");
        }
        //
        // GET: /student/Create

        public ActionResult AddInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            //性别           
            List<SelectListItem> sexlist = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.sex)))
            {
                string names = Enum.GetName(typeof(PublicEnum.sex), item);
                sexlist.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["sex"] = sexlist;

            //民族
            List<SelectListItem> nationlist = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.nation)))
            {
                string names = Enum.GetName(typeof(PublicEnum.nation), item);
                nationlist.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["nation"] = nationlist;

            //政治面貌
            List<SelectListItem> politicalOutlookList = new List<SelectListItem>();
            //循环遍历枚举中的值
            foreach (int item in Enum.GetValues(typeof(PublicEnum.politicalOutlook)))
            {
                string names = Enum.GetName(typeof(PublicEnum.politicalOutlook), item);
                politicalOutlookList.Add(new SelectListItem() { Text = names, Value = names });
            }
            ViewData["politicalOutlook"] = politicalOutlookList;

            //所在班级
            DBDataContext db = new DBDataContext();
            IEnumerable<SelectListItem> classlist = db.classes.ToList().Select(a => new SelectListItem()
            {
                Text = a.cl_name,
                Value = a.cl_id.ToString()
            });
            ViewData["class"] = classlist;

            return View();
        }

        //
        // POST: /student/Create

        [HttpPost]
        public ActionResult AddInfo(FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add insert logic here
                using (DBDataContext db = new DBDataContext())
                {
                    student stu = new student();
                    stu.stu_password = "123456";
                    stu.stu_name = collection["stu_name"];
                    string ds = collection["stu_sex"];
                    stu.stu_sex = collection["stu_sex"];
                    stu.stu_birth = Convert.ToDateTime(collection["stu_birth"]);
                    stu.stu_nation = collection["stu_nation"];
                    stu.stu_cid = collection["stu_cid"];
                    stu.stu_tel = collection["stu_tel"];
                    stu.stu_address = collection["stu_address"];
                    stu.stu_clid = Convert.ToInt32(collection["stu_clid"]);
                    stu.stu_politicalOutlook = collection["stu_politicalOutlook"];
                    stu.stu_joinTime = Convert.ToDateTime(collection["stu_joinTime"]);
                    stu.stu_highSchool = collection["stu_highSchool"];
                    stu.stu_remark = collection["stu_remark"];
                    db.student.InsertOnSubmit(stu);
                    db.SubmitChanges();
                }
                return RedirectToAction("StudentList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /student/Edit/5

        public ActionResult StudentInfo(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                student stu = (from a in db.student where a.stu_num == id select a).First();
                //性别           
                List<SelectListItem> sexlist = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.sex)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.sex), item);
                    if (stu.stu_sex == names)
                    {
                        sexlist.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        sexlist.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["sex"] = sexlist;

                //民族
                List<SelectListItem> nationlist = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.nation)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.nation), item);
                    if (stu.stu_nation == names)
                    {
                        nationlist.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        nationlist.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["nation"] = nationlist;

                //政治面貌
                List<SelectListItem> politicalOutlookList = new List<SelectListItem>();
                //循环遍历枚举中的值
                foreach (int item in Enum.GetValues(typeof(PublicEnum.politicalOutlook)))
                {
                    string names = Enum.GetName(typeof(PublicEnum.politicalOutlook), item);
                    if (stu.stu_politicalOutlook == names)
                    {
                        politicalOutlookList.Add(new SelectListItem() { Text = names, Value = names, Selected = true });
                    }
                    else
                    {
                        politicalOutlookList.Add(new SelectListItem() { Text = names, Value = names });
                    }
                }
                ViewData["politicalOutlook"] = politicalOutlookList;

                //所在班级
                IEnumerable<SelectListItem> classlist = db.classes.ToList().Select(a => new SelectListItem()
                {
                    Text = a.cl_name,
                    Value = a.cl_id.ToString()
                });
                foreach (var item in classlist)
                {
                    if (item.Value == stu.stu_clid.ToString())
                    {
                        item.Selected = true;
                    }
                }
                ViewData["class"] = classlist;
                return View(stu);
            }

        }

        //
        // POST: /student/Edit/5

        [HttpPost]
        public ActionResult StudentInfo(int id, FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add update logic here
                using (DBDataContext db = new DBDataContext())
                {
                    student stu = (from a in db.student where a.stu_num == id select a).First();
                    stu.stu_name = collection["stu_name"];
                    stu.stu_sex = collection["stu_sex"];
                    stu.stu_birth = Convert.ToDateTime(collection["stu_birth"]);
                    stu.stu_nation = collection["stu_nation"];
                    stu.stu_cid = collection["stu_cid"];
                    stu.stu_tel = collection["stu_tel"];
                    stu.stu_address = collection["stu_address"];
                    stu.stu_clid = Convert.ToInt32(collection["stu_clid"]);
                    stu.stu_politicalOutlook = collection["stu_politicalOutlook"];
                    stu.stu_joinTime = Convert.ToDateTime(collection["stu_joinTime"]);
                    stu.stu_highSchool = collection["stu_highSchool"];
                    stu.stu_remark = collection["stu_remark"];
                    db.SubmitChanges();
                }
                return RedirectToAction("StudentList");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /student/Delete/5

        public ActionResult Delete(int id)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                student stu = (from a in db.student where a.stu_num == id select a).First();
                return View(stu);
            }
        }

        //
        // POST: /student/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                if (Session["id"] == null)
                {
                    return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                }
                // TODO: Add delete logic here
                using (DBDataContext db = new DBDataContext())
                {
                    student stu = (from a in db.student where a.stu_num == id select a).First();
                    db.student.DeleteOnSubmit(stu);
                    db.SubmitChanges();
                }
                return RedirectToAction("StudentList");
            }
            catch
            {
                return View();
            }
        }
    }
}
