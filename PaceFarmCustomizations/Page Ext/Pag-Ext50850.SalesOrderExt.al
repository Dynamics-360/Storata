pageextension 50850 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addbefore(Status)
        {
            field(SDN; Rec.SDN)
            {
                ApplicationArea = All;
            }
            field("Truck Rego"; Rec."Truck Rego")
            {
                ApplicationArea = All;
            }
        }
    }
}
