pageextension 50850 PF_SalesOrderExt extends "Sales Order"
{
    layout
    {
        addbefore(Status)
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
        addbefore("Shipment Method Code")
        {
            field("Delivery Terms"; Rec."Delivery Terms")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Post)
        {
            action("Create Stock")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CustomUtility: Codeunit PF_CustomUtility;
                begin
                    CustomUtility.UpdateStockUsingItemJournal(Rec);
                end;
            }
        }
    }
}
