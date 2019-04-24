<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<EducationManager.Models.score>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Detail</title>
</head>
<body>
    <fieldset>
        <legend>Fields</legend>
        
        <div class="display-label">sc_id</div>
        <div class="display-field"><%: Model.sc_id %></div>
        
        <div class="display-label">sc_stuNum</div>
        <div class="display-field"><%: Model.sc_stuNum %></div>
        
        <div class="display-label">sc_csid</div>
        <div class="display-field"><%: Model.sc_csid %></div>
        
        <div class="display-label">sc_usuallyScore</div>
        <div class="display-field"><%: Model.sc_usuallyScore %></div>
        
        <div class="display-label">sc_endScore</div>
        <div class="display-field"><%: Model.sc_endScore %></div>
        
        <div class="display-label">sc_poportion</div>
        <div class="display-field"><%: Model.sc_poportion %></div>
        
        <div class="display-label">sc_sumScore</div>
        <div class="display-field"><%: Model.sc_sumScore %></div>
        
        <div class="display-label">sc_remark</div>
        <div class="display-field"><%: Model.sc_remark %></div>
        
    </fieldset>
    <p>

        <%: Html.ActionLink("Edit", "Edit", new { id=Model.sc_id }) %> |
        <%: Html.ActionLink("Back to List", "Index") %>
    </p>

</body>
</html>

