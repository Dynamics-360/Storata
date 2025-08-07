pageextension 60453 SalesLinesExt extends "Sales Lines"
{
    Editable = true;
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
