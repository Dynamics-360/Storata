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
        addafter("No. Printed")
        {
            field("Work Description"; WorkDesc)
            {
                ApplicationArea = All;
                MultiLine = true;
                Editable = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        WorkDesc := Rec.GetWorkDescription();
    end;

    var
        WorkDesc: Text;
}