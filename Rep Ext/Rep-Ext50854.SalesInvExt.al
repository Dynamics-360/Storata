reportextension 50854 SalesInvExt extends "PF Posted Sales Invoice"
{
    dataset
    {
        add("Sales Invoice Header")
        {
            column(SDN; SDN)
            {
            }
            column(Truck_Rego; "Truck Rego")
            {
            }
        }
        add("Sales Invoice Line")
        {
            column(PickCode; Item."Pick Code")
            {
            }
        }
    }
    rendering
    {
        layout("SalesInv - D360")
        {
            Type = RDLC;
            LayoutFile = './PostedSalesInvoice-Modified.rdl';
        }
    }
    var
        Item: Record Item;
}
