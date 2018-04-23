using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using DevExpress.Web.Data;
using DevExpress.Web.ASPxGridView;

public partial class _Default: System.Web.UI.Page {
    protected List<GridDataItem> GridData {
        get {
            var key = "34FAA431-CF79-4869-9488-93F6AAE81263";
            if (!IsPostBack || Session[key] == null)
                Session[key] = Enumerable.Range(1, 100).Select(i => new GridDataItem
                {
                    ID = i,
                    Quantity = i * 10 % 7 % i,
                    Price = i * 0.5 % 3
                }).ToList();
            return (List<GridDataItem>)Session[key];
        }
    }
    protected void Page_Load(object sender, EventArgs e) {
        Grid.DataSource = GridData;
        Grid.DataBind();
    }
    protected void Grid_RowInserting(object sender, ASPxDataInsertingEventArgs e) {
        InsertNewItem(e.NewValues);
        CancelEditing(e);
    }
    protected void Grid_RowUpdating(object sender, ASPxDataUpdatingEventArgs e) {
        UpdateItem(e.Keys, e.NewValues);
        CancelEditing(e);
    }
    protected void Grid_RowDeleting(object sender, ASPxDataDeletingEventArgs e) {
        DeleteItem(e.Keys, e.Values);
        CancelEditing(e);
    }
    protected void Grid_BatchUpdate(object sender, ASPxDataBatchUpdateEventArgs e) {
        foreach (var args in e.InsertValues)
            InsertNewItem(args.NewValues);
        foreach (var args in e.UpdateValues)
            UpdateItem(args.Keys, args.NewValues);
        foreach (var args in e.DeleteValues)
            DeleteItem(args.Keys, args.Values);

        e.Handled = true;
    }
    protected GridDataItem InsertNewItem(OrderedDictionary newValues) {
        var item = new GridDataItem() { ID = GridData.Count };
        LoadNewValues(item, newValues);
        GridData.Add(item);
        return item;
    }
    protected GridDataItem UpdateItem(OrderedDictionary keys, OrderedDictionary newValues) {
        var id = Convert.ToInt32(keys["ID"]);
        var item = GridData.First(i => i.ID == id);
        LoadNewValues(item, newValues);
        return item;
    }
    protected GridDataItem DeleteItem(OrderedDictionary keys, OrderedDictionary values) {
        var id = Convert.ToInt32(keys["ID"]);
        var item = GridData.First(i => i.ID == id);
        GridData.Remove(item);
        return item;
    }
    protected void LoadNewValues(GridDataItem item, OrderedDictionary values) {
        item.Quantity = Convert.ToInt32(values["Quantity"]);
        item.Price = Convert.ToDouble(values["Price"]);
    }
    protected void CancelEditing(CancelEventArgs e) {
        e.Cancel = true;
        Grid.CancelEdit();
    }
    public class GridDataItem {
        public int ID { get; set; }
        public int Quantity { get; set; }
        public double Price { get; set; }
    }
    protected void Grid_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e) {
        if (e.Column.FieldName == "Sum") {
            decimal price = Convert.ToDecimal(e.GetListSourceFieldValue("Price"));
            int quantity = Convert.ToInt32(e.GetListSourceFieldValue("Quantity"));

            e.Value = price * quantity;
        }

    }
    protected void Grid_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e) {
        if (e.DataColumn.FieldName == "Sum")
                      e.Cell.Attributes.Add("onclick", "event.cancelBubble = true");                     
    }
}