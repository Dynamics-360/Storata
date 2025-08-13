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
            field("Product Relv. Temp."; Rec."Product Relv. Temp.")
            {
                ApplicationArea = All;
            }
            group(PFReturn)
            {
                Caption = 'PF - Return';
                field("Date Produced/UBD"; Rec."Date Produced/UBD")
                {
                    ApplicationArea = All;
                }
                field("Warehouse Supervisor"; Rec."Warehouse Supervisor")
                {
                    ApplicationArea = All;
                }
                field("Store Man"; Rec."Store Man")
                {
                    ApplicationArea = All;
                }
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = All;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = All;
                }
                field("Run No."; Rec."Run No.")
                {
                    ApplicationArea = All;
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                }

            }
        }
        addlast("Adjustment Details")
        {
            field("Action Taken"; Rec."Action Taken")
            {
                ApplicationArea = All;
            }
            field("Action Take Comment"; Rec."Action Take Comment")
            {
                ApplicationArea = All;
            }
            field("Reason for Return Comment"; Rec."Reason for Return Comment")
            {
                ApplicationArea = All;
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