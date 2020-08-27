<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function OnBatchEditEndEditing(s, e) {
            window.setTimeout(function () {
                var price = s.batchEditApi.GetCellValue(e.visibleIndex, "Price");
                var quantity = s.batchEditApi.GetCellValue(e.visibleIndex, "Quantity");
                s.batchEditApi.SetCellValue(e.visibleIndex, "Sum", price * quantity, null, true);
            }, 10);
        }
    </script>
</head>
<body>
    <form id="frmMain" runat="server">
    <dx:ASPxGridView ID="Grid" runat="server" KeyFieldName="ID" OnBatchUpdate="Grid_BatchUpdate"
        OnRowInserting="Grid_RowInserting" OnRowUpdating="Grid_RowUpdating" OnRowDeleting="Grid_RowDeleting"
        OnCustomUnboundColumnData="Grid_CustomUnboundColumnData" >
        <ClientSideEvents  BatchEditEndEditing="OnBatchEditEndEditing" />
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
                <Settings ShowEditorInBatchEditMode="false" />
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="Batch" />       
    </dx:ASPxGridView>
    </form>
</body>
</html>
