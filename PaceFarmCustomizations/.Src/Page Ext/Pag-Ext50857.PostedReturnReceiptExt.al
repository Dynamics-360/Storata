pageextension 50857 PostedReturnReceiptExt extends "Posted Return Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
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

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}