using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EducationManager.Models;
using System.Collections;
using System.Web.Services;

namespace EducationManager.Controllers
{
    public class EducationManagerController : Controller
    {
        //
        // GET: /EducationManager/

        /// <summary>
        /// 首页
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            if (Session["id"] == null)
            {
                //return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
                //return Content("<script>window.open('../UserInfo/LoginOn','_blank');</script>");
                return RedirectToAction("../UserInfo/LoginOn");
            }
            DBDataContext db=new DBDataContext();
            List<webInfo> list=(from a in db.webInfo select a).ToList();
            ViewData["list"] = null;
            if (list != null)
            {
                ViewData["list"] =list;
                webInfo wi = list.First();
                ViewData["desc"] = wi.web_desc;//描述
                ViewData["key"] = wi.web_keywords;//关键字
                ViewData["address"] = wi.web_address;//地址
                ViewData["post"] = wi.web_postcode;//邮编
                ViewData["copy"] = wi.web_copyright;//版权
                ViewData["tel"] = wi.web_tel;//联系电话
            }

            //查询权限
            List<menuInfo> mlist = (from a in db.menuInfo where a.mn_pId==null select a).ToList();
            ViewData["minfo"] = mlist;
           List<powers> llist = (from a in db.powers
                                     where a.pr_roles == Convert.ToInt32(Session["role"])
                                     select a).ToList();
           ViewData["pinfo"] = llist;
           List<int> pids = new List<int>();
           foreach (powers item in llist)
           {
               pids.Add(Convert.ToInt32(item.menuInfo.mn_pId));
           }
           ViewData["pids"] = pids;
           ViewData["id"] = Session["id"];
            return View();
        }
        /// <summary>
        /// 网站设置页面
        /// </summary>
        /// <returns></returns>
        public ActionResult WebInfo()
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                List<webInfo> list = (from a in db.webInfo select a).ToList();
                ViewData["list"] = list;
                if (list.Count<=0)//如果还没有添加网站基本信息则不返回数据否则返回数据将数据显示在页面中
                {
                    return View();
                }
                else
                {
                    return View(list.First());
                }
            }
        }
        [HttpPost]
        public ActionResult WebInfo(FormCollection collection)
        {
            if (Session["id"] == null)
            {
                return Content("<script>window.open('../UserInfo/LoginOn','_blank')</script>");
            }
            using (DBDataContext db = new DBDataContext())
            {
                List<webInfo> list = (from a in db.webInfo select a).ToList();                
                if (list.Count <= 0)//如果还没有网站基本信息则添加网站基本信息，否则就修改网站信息
                {
                    webInfo wi = new webInfo();
                    wi.web_copyright = collection["web_copyright"];
                    wi.web_address = collection["web_address"];
                    wi.web_postcode = collection["web_postcode"];
                    wi.web_tel = collection["web_tel"];
                    wi.web_keywords = collection["web_keywords"];
                    wi.web_desc = collection["web_desc"];
                    wi.web_address = collection["web_address"];
                    wi.web_address = collection["web_address"];
                    wi.web_managerUserID = 1;//要替换成session中的用户id
                    wi.web_createTime = DateTime.Now;
                    wi.web_modifyIP = "127.0.0.1";
                    db.webInfo.InsertOnSubmit(wi);
                    db.SubmitChanges();                   
                }
                else
                {
                    webInfo wi = (from a in db.webInfo select a).First();
                    wi.web_copyright = collection["web_copyright"];
                    wi.web_address = collection["web_address"];
                    wi.web_postcode = collection["web_postcode"];
                    wi.web_tel = collection["web_tel"];
                    wi.web_keywords = collection["web_keywords"];
                    wi.web_desc = collection["web_desc"];
                    wi.web_address = collection["web_address"];
                    wi.web_address = collection["web_address"];
                    wi.web_managerUserID = 1;
                    wi.web_createTime = DateTime.Now;
                    wi.web_modifyIP = "127.0.0.1";
                    db.SubmitChanges();                    
                }
                return RedirectToAction("WebInfo");
            }
        }
    }
}
