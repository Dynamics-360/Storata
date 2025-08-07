pageextension 60452 SalesInv extends "Posted Sales Invoice"
{
    layout
    {
        addbefore("Work Description")
        {
            field("Run No."; Rec."Run No.")
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
}
