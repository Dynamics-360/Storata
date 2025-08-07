pageextension 50854 PF_SalesCrMemoExt extends "Sales Credit Memo"
{
    layout
    {
        addbefore("Work Description")
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
        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()
            var
                SalesInvHead: Record "Sales Invoice Header";
            begin
                if not (Rec."Applies-to Doc. Type" = Rec."Applies-to Doc. Type"::Invoice) then
                    exit;

                if SalesInvHead.Get(Rec."Applies-to Doc. No.") then begin
                    Rec.SDN := SalesInvHead.SDN;
                    Rec."Truck Rego" := SalesInvHead."Truck Rego";
                    Rec.Modify();
                end;
            end;
        }
    }
}
