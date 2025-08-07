table 60454 "Call Sheet"
{
    Caption = 'Call Sheet';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
            DataClassification = CustomerContent;

        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Run No"; Code[20])
        {
            Caption = 'Run No';
            TableRelation = Runs;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Run Day"; Option)
        {
            Caption = 'Run Day';
            DataClassification = CustomerContent;
            Editable = false;
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday;
        }
        field(5; "Run Date"; Date)
        {
            Caption = 'Run Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Call Day"; Option)
        {
            Caption = 'Call Day';
            DataClassification = CustomerContent;
            Editable = false;
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday;
        }
        field(7; "Call Date"; Date)
        {
            Caption = 'Call Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Customer State"; Text[30])
        {
            Caption = 'Customer State';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Call Group"; Code[10])
        {
            Caption = 'Call Group';
            DataClassification = CustomerContent;
        }
        field(11; Comment; Text[250])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
        field(13; "Call Back"; Boolean)
        {
            Caption = 'Call Back';
            DataClassification = CustomerContent;
        }
        field(14; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
        }
        field(15; Holidays; Integer)
        {
            Caption = 'Holidays';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; Blocked; Enum "Customer Blocked")
        {
            Caption = 'Blocked';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Blocked" where("No." = field("Customer No.")));
        }
        field(17; "Sales Phone Number"; Text[30])
        {
            Caption = 'Sales Phone Number';
            ExtendedDatatype = PhoneNo;
            Editable = false;
        }
        field(18; "Sales Contact"; Text[100])
        {
            Caption = 'Sales Email';
            ExtendedDatatype = Email;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Sales Contact" where("No." = field("Customer No.")));
        }
        field(19; "Sales Note"; Blob)
        {
            Caption = 'Sales Note';
            DataClassification = CustomerContent;
        }
        field(20; "Drop No"; Text[30])
        {
            Caption = 'Drop No';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Drop No." where("No." = field("Customer No.")));
        }
        field(21; "Holiday Date Changed"; Boolean)
        {
            Caption = 'Holiday Date Changed';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    procedure GetNotesTxt(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Sales Note");
        "Sales Note".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Sales Note")));
    end;

    procedure SetNotesTxt(NewSalesNoteTxt: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Sales Note");
        "Sales Note".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewSalesNoteTxt);
    end;
}
