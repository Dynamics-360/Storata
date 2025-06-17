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
        }
    }
}
