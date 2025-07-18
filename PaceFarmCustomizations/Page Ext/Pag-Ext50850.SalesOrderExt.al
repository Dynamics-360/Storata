pageextension 50850 SalesOrderExt extends "Sales Order"
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
                    Process: Codeunit Processing;
                begin
                    Process.UpdateStockUsingItemJournal(Rec);
                end;
            }
        }
    }
}
