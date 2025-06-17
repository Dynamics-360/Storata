pageextension 60451 SalesOrdExt extends "Sales Order"
{
    layout
    {
        addbefore(Status)
        {
            field("Run No."; Rec."Run No.")
            {
                ApplicationArea = All, Basic, Suite;
            }
        }
    }
}
