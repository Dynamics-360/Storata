pageextension 60455 SalesLineExt extends "Sales Order Subform"
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
