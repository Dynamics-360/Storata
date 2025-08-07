pageextension 50857 PF_PostedReturnReceiptExt extends "Posted Return Receipt"
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
    var
        EventMgt: Codeunit "PF_EventMgt";
    begin
        WorkDesc := EventMgt.GetWorkDescription(Rec);
    end;

    var
        WorkDesc: Text;
}