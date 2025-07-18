pageextension 50852 SalesInvExt extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Dispute Status")
        {
            field(SDN;Rec.SDN)
            {
                ApplicationArea = All;
            }
            field("Truck Rego";Rec."Truck Rego")
            {
                ApplicationArea = All;
            }
        }
    }
}
