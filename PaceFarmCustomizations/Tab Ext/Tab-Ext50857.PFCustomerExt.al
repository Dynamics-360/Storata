tableextension 50857 PFCustomerExt extends Customer
{
    fields
    {
        field(50850; "Sales Note"; Blob)
        {
            Caption = 'Sales Note';
            DataClassification = ToBeClassified;
        }
        field(50851; "Sales Phone Number"; Text[30])
        {
            Caption = 'Sales Note Text';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(50852; "Sales Contact"; Code[20])
        {
            Caption = 'Sales Contact';
            TableRelation = Contact;
            DataClassification = CustomerContent;
        }
        modify("Credit Limit (LCY)")
        {
            trigger OnAfterValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if not UserSetup.Get(UserId()) then
                    exit;
                if not UserSetup."Can Modify Credit Limit" then
                    Error('You do not have permission to modify the credit limit for this customer.');
            end;
        }
    }
    procedure GetSalesNote() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Sales Note");
        "Sales Note".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Sales Note")));
    end;

    procedure SetSalesNote(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Sales Note");
        "Sales Note".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;
}
