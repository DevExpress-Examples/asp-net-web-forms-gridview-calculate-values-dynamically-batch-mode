# ASPxGridView - Batch Edit - How to calculate values on the fly


<p>This example demonstrates how to create an unbound column that calculates the sum of other columns and changes its values on the fly when end-user changes any grid values using Batch edit mode. </p>
<p>You can find detailed steps by clicking below the "Show Implementation Details" link .<br><strong><br>See Also:</strong></p>
<p><a href="https://www.devexpress.com/Support/Center/p/T114923">ASPxGridView - How to update total summaries on the client side in Batch Edit mode</a><br><a href="https://www.devexpress.com/Support/Center/p/T116925">ASPxGridView - Batch Edit - How to calculate unbound column and total summary values on the fly</a> <br><a href="https://www.devexpress.com/Support/Center/p/T558750">ASPxGridView - Batch Edit - How to change a cell value based on another cell value</a><br><br><strong>ASP.NET MVC Example:</strong><br><a href="https://www.devexpress.com/Support/Center/p/T124603">GridView - Batch Edit - How to calculate values on the fly</a></p>


<h3>Description</h3>

<p>To implement the required task, perform the following steps:</p>
<p><br>1. Create an unbound column in the same manner as described in the&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridViewASPxGridView_CustomUnboundColumnDatatopic">ASPxGridView.CustomUnboundColumnData Event</a>&nbsp;help article:</p>
<code lang="aspx">&lt;dx:GridViewDataTextColumn FieldName="Sum" UnboundType="Decimal" ReadOnly="true"&gt;
&lt;/dx:GridViewDataTextColumn&gt;</code>
<code lang="cs">protected void Grid_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e) {
	if (e.Column.FieldName == "Sum") {
		decimal price = Convert.ToDecimal(e.GetListSourceFieldValue("Price"));
		int quantity = Convert.ToInt32(e.GetListSourceFieldValue("Quantity"));
&nbsp;		e.Value = price * quantity;
	}
}
</code>
<p>2. Handle the client-side&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridViewScriptsASPxClientGridView_BatchEditStartEditingtopic">ASPxClientGridView.BatchEditStartEditing</a>&nbsp;event to cancel editing for the Sum column:</p>
<code lang="js">function OnBatchEditStartEditing(s, e) {
    e.cancel = (e.focusedColumn.fieldName =='Sum');           
}
</code>
<p>&nbsp;3. Handle the&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridViewScriptsASPxClientGridView_BatchEditEndEditingtopic">ASPxClientGridView.BatchEditEndEditing</a>&nbsp;event to re-calculate the values based on the new changes and set it to the unbound column using the&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridViewScriptsASPxClientGridViewBatchEditApi_SetCellValuetopic">ASPxClientGridViewBatchEditApi.SetCellValue</a>&nbsp;method:</p>
<code lang="js">function OnBatchEditEndEditing(s, e) {
	window.setTimeout(function () {
		var price = s.batchEditApi.GetCellValue(e.visibleIndex, "Price");
		var quantity = s.batchEditApi.GetCellValue(e.visibleIndex, "Quantity");
		s.batchEditApi.SetCellValue(e.visibleIndex, "Sum", price * quantity);
	}, 10);
}</code>

<br/>


