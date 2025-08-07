table 60453 Holidays
{
    Caption = 'Holidays';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(9; "State"; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
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
