pageextension 50855 PostedSalesCrMemoExt extends "Posted Sales Credit Memo"
{
    layout
    {
        addbefore("Work Description")
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

}