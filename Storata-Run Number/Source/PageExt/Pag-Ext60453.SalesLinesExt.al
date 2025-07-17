pageextension 60453 SalesLinesExt extends "Sales Lines"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Run No."; Rec."Run No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
