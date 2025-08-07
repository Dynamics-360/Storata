pageextension 50858 PF_SalesReturnOrderExt extends "Sales Return Order"
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
        addafter(Status)
        {
            field("Work Description"; WorkDesc)
            {
                ApplicationArea = All;
                MultiLine = true;
                trigger OnValidate()
                begin
                    Rec.SetWorkDescription(WorkDesc);
                end;
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