<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bsk-visualizar-proposta.aspx.cs" Inherits="Bsk.Site.Admin.bsk_visualizar_proposta" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Proposta StudioBrasuka</title>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

    <form id="form1" runat="server">
             <% string CodigoProposta = "";
                if (!String.IsNullOrEmpty(Request.QueryString["CodigoProposta"]))
                CodigoProposta = Request.QueryString["CodigoProposta"];%>
                        <%Response.Write(HtmlProposta(CodigoProposta));%>
    </form>
</body>
</html>

