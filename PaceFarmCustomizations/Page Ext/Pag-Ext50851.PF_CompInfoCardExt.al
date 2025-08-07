pageextension 50851 PF_CompInfoCardExt
 extends "Company Information"
{
    layout
    {
        addafter("E-Mail")
        {
            field("AR Email"; Rec."AR Email")
            {
                ApplicationArea = All;
            }
        }
    }
}
