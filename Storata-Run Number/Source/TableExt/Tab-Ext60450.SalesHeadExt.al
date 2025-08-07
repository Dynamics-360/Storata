tableextension 60450 SalesHeadExt extends "Sales Header"
{
    fields
    {
        field(60450; "Run No."; Code[20])
        {
            Caption = 'Run No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60451; "Req SSCC"; Boolean)
        {
            Caption = 'Req SSCC';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Req SSCC" where("No." = field("Sell-to Customer No.")));
        }
        field(60452; "Req COA"; Boolean)
        {
            Caption = 'Req COA';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.ReqCOA where("No." = field("Sell-to Customer No.")));
        }
        field(60453; "Requires Electronic Invoice"; Boolean)
        {
            Caption = 'Requires Electronic Invoice';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Req. Electronic Inv." where("No." = field("Sell-to Customer No.")));
        }
        field(60454; "Drop No"; Text[30])
        {
            Caption = 'Drop No';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Customer."Drop No." where("No." = field("Sell-to Customer No.")));
        }
        field(50854; "SO_External Delivery Note"; Blob)
        {
            Caption = 'External Delivery Note';
            DataClassification = CustomerContent;
        }
        field(50855; "SO_Pick Note"; Blob)
        {
            Caption = 'Pick Note';
            DataClassification = CustomerContent;
        }
        field(50856; "SO_Posted Invoice Note"; Blob)
        {
            Caption = 'Posted Invoice Note';
            DataClassification = CustomerContent;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.get("Sell-to Customer No.") then begin
                    Rec.SetExternalDeliveryNote(CustomerRec.GetExternalDeliveryNote());
                    Rec.SetPickNote(CustomerRec.GetPickNote());
                    Rec.SetPostedInvoicekNote(CustomerRec.GetPostedInvoiceNote());
                    Rec.Modify();
                end;
            end;
        }
    }
    procedure GetExternalDeliveryNote() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("SO_External Delivery Note");
        "SO_External Delivery Note".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("SO_External Delivery Note")));
    end;

    procedure SetExternalDeliveryNote(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("SO_External Delivery Note");
        "SO_External Delivery Note".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;

    procedure GetPickNote() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("SO_Pick Note");
        "SO_Pick Note".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("SO_Pick Note")));
    end;

    procedure SetPickNote(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("SO_Pick Note");
        "SO_Pick Note".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;

    procedure GetPostedInvoiceNote() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("SO_Posted Invoice Note");
        "SO_Posted Invoice Note".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("SO_Posted Invoice Note")));
    end;

    procedure SetPostedInvoicekNote(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("SO_Posted Invoice Note");
        "SO_Posted Invoice Note".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;
}
