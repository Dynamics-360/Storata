table 60453 Holidays
{
    Caption = 'Holidays';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(9; "State"; Code[20])
        {
            Caption = 'State';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
    }
    keys
    {
        key(PK; "Date")
        {
            Clustered = true;
        }
    }
}
