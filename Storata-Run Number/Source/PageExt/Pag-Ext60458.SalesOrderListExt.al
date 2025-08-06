pageextension 60458 PF_SalesOrderList extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Run No.";Rec."Run No.")
            {
                ApplicationArea = All;
            }
            field("Drop No"; Rec."Drop No")
            {
                ApplicationArea = All;
            }
            field("Req SSCC"; Rec."Req SSCC")
            {
                ApplicationArea = All;
            }
            field("Req COA"; Rec."Req COA")
            {
                ApplicationArea = All;
            }
            field("Requires Electronic Invoice"; Rec."Requires Electronic Invoice")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Print Confirmation")
        {
            Visible = false;
        }
        modify("Email Confirmation")
        {
            Visible = false;
        }
        modify(PostAndSend)
        {
            Visible = false;
        }
    }
}