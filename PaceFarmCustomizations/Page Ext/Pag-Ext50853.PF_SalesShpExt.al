pageextension 50853 PF_SalesShpExt extends "Posted Sales Shipment"
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
