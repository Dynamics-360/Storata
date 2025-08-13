table 50857 Storeman
{
    Caption = 'Storeman';
    DataClassification = CustomerContent;
    LookupPageId = Storeman;
    DrillDownPageId = Storeman;

    fields
    {
        field(1; "Storeman No."; Code[20])
        {
            Caption = 'Storeman No.';
        }
        field(2; "Storeman Name"; Text[100])
        {
            Caption = 'Storeman Name';
        }
        field(3; Active; Boolean)
        {
            Caption = 'Active';
        }
    }
    keys
    {
        key(PK; "Storeman No.")
        {
            Clustered = true;
        }
    }
}
