pageextension 50853 SalesShpDoc extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Responsibility Center")
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
