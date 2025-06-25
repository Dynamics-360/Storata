pageextension 50851 CompInfoCard extends "Company Information"
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
