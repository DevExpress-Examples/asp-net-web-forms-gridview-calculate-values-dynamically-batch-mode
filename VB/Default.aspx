<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        var currentColumnName;
        function OnBatchEditStartEditing(s, e) {
            currentColumnName = e.focusedColumn.fieldName;
        }

        function OnBatchEditEndEditing(s, e) {
            window.setTimeout(function () {
                var price = s.batchEditApi.GetCellValue(e.visibleIndex, "Price");
                var quantity = s.batchEditApi.GetCellValue(e.visibleIndex, "Quantity");
                s.batchEditApi.SetCellValue(e.visibleIndex, "Sum", price * quantity);
            }, 10);
        }
    </script>
</head>
<body>
    <form id="frmMain" runat="server">
    <dx:ASPxGridView ID="Grid" runat="server" KeyFieldName="ID" OnBatchUpdate="Grid_BatchUpdate"
        OnRowInserting="Grid_RowInserting" OnRowUpdating="Grid_RowUpdating" OnRowDeleting="Grid_RowDeleting"
        OnCustomUnboundColumnData="Grid_CustomUnboundColumnData" OnHtmlDataCellPrepared="Grid_HtmlDataCellPrepared">
        <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEditing" BatchEditEndEditing="OnBatchEditEndEditing" />
        <Columns>
            <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowDeleteButton="true" />
            <dx:GridViewDataSpinEditColumn FieldName="Quantity">
                <PropertiesSpinEdit MinValue="0" MaxValue="99999">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn FieldName="Price">
                <PropertiesSpinEdit MinValue="0" MaxValue="99999">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn FieldName="Sum" UnboundType="Decimal" ReadOnly="true">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="Batch" />
        <ClientSideEvents BatchEditStartEditing="function(s, e){ e.cancel = (e.focusedColumn.fieldName =='Sum'); }" />
    </dx:ASPxGridView>
    </form>
</body>
</html>