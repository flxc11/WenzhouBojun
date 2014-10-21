<%
Session.CodePage = 65001
Response.Charset = "UTF-8"
Response.Cookies("CNVP_CMS2")("UserName")=""
Response.Cookies("CNVP_CMS2")("SiteVersion")=""
Response.Cookies("CNVP_CMS2")("ClassPage")=""
Response.Cookies("CNVP_CMS2")("attributeValue")=""
Response.Cookies("CNVP_CMS2")("fieldname")=""
Response.Cookies("CNVP_CMS2")("fieldname2")=""
Response.Cookies("CNVP_CMS2")("attributeValue2")=""
Response.Cookies("CMS_CNVP")("ISAdmin")=""
Response.Redirect("Admin_Login.asp")
%>