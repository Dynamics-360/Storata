pageextension 50858 SalesReturnOrderExt extends "Sales Return Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field(SDN; Rec.SDN)
            {
                ApplicationArea = all;
            }
            field("Truck Rego"; Rec."Truck Rego")
            {
                ApplicationArea = all;
            }
        }
    }

}