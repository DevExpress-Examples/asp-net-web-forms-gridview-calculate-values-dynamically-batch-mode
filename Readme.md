<!-- default file list -->
*Files to look at*:

* **[Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))**
* [Default.aspx.cs](./CS/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/Default.aspx.vb))
<!-- default file list end -->
# ASPxGridView - Batch Edit - How to calculate values on the fly


<p>This example demonstrates how to create an unbound column that calculates the sum of other columns and changes its values on the fly when end-user changes any grid values using Batch edit mode. </p>
<p>You can find detailed steps by clicking below the "Show Implementation Details" link .<br><strong><br>See Also:</strong></p>
<p><a href="https://www.devexpress.com/Support/Center/p/T114923">ASPxGridView - How to update total summaries on the client side in Batch Edit mode</a><br><a href="https://www.devexpress.com/Support/Center/p/T116925">ASPxGridView - Batch Edit - How to calculate unbound column and total summary values on the fly</a> <br><a href="https://www.devexpress.com/Support/Center/p/T558750">ASPxGridView - Batch Edit - How to change a cell value based on another cell value</a><br><br><strong>ASP.NET MVC Example:</strong><br><a href="https://www.devexpress.com/Support/Center/p/T124603">GridView - Batch Edit - How to calculate values on the fly</a></p>


<h3>Description</h3>

<p>Starting with v16.1, it's possible to modify cells without highlighting using the corresponding&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridViewBatchEditApi_SetCellValuetopic">ASPxClientGridViewBatchEditApi.SetCellValue</a>&nbsp;method overload and make a column non-editable for a user using the&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebGridDataColumnSettings_ShowEditorInBatchEditModetopic">GridDataColumnSettings.ShowEditorInBatchEditMode</a>&nbsp;property.</p>
<code lang="aspx"> &lt;dx:GridViewDataTextColumn FieldName="Sum" UnboundType="Decimal" ReadOnly="true"&gt;
                &lt;Settings ShowEditorInBatchEditMode="false" /&gt;
 &lt;/dx:GridViewDataTextColumn&gt;</code>
<code lang="js">function OnBatchEditEndEditing(s, e) {
            window.setTimeout(function () {
                var price = s.batchEditApi.GetCellValue(e.visibleIndex, "Price");
                var quantity = s.batchEditApi.GetCellValue(e.visibleIndex, "Quantity");
                s.batchEditApi.SetCellValue(e.visibleIndex, "Sum", price * quantity, null, true);
            }, 0);
}</code>

<br/>


