pageextension 50859 PF_ReqWorShtExt extends "Req. Wksh. Names"
{
    layout
    {
        addafter(Description)
        {
            field(Lines; Rec.Lines)
            { ApplicationArea = All; }
        }
    }
}
