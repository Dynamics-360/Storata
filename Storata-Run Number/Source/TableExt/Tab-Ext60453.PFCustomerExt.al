tableextension 60453 PFCustomerExt extends Customer
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
        field(50853; "Drop No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Drop No.';
        }
        field(50854; "External Delivery Note"; Blob)
        {
            Caption = 'External Delivery Note';
            DataClassification = CustomerContent;
        }
        field(50855; "Pick Note"; Blob)
        {
            Caption = 'Pick Note';
            DataClassification = CustomerContent;
        }
        field(50856; "Posted Invoice Note"; Blob)
        {
            Caption = 'Posted Invoice Note';
            DataClassification = CustomerContent;
        }
        field(50857; "Req. Electronic Inv."; Boolean)
        {
            Caption = 'Requires Electronic Invoice';
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

    procedure GetExternalDeliveryNote() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("External Delivery Note");
        "External Delivery Note".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("External Delivery Note")));
    end;

    procedure SetExternalDeliveryNote(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("External Delivery Note");
        "External Delivery Note".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;

    procedure GetPickNote() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Pick Note");
        "Pick Note".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Pick Note")));
    end;

    procedure SetPickNote(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Pick Note");
        "Pick Note".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;

    procedure GetPostedInvoiceNote() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Posted Invoice Note");
        "Posted Invoice Note".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Posted Invoice Note")));
    end;

    procedure SetPostedInvoicekNote(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Posted Invoice Note");
        "Posted Invoice Note".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;
}
