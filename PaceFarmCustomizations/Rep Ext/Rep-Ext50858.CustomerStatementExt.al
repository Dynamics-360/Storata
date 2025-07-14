reportextension 50858 CustomerStatementExt extends "Standard Statement"
{
    dataset
    {
        modify(DtldCustLedgEntries)
        {
            trigger OnAfterAfterGetRecord()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
            begin
                if CustLedgerEntry.Get("Cust. Ledger Entry No.") then
                    ExternelDocNo := CustLedgerEntry."External Document No.";
            end;

        }
        add(Customer)
        {
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {

            }
            column(ExternelDocNo; ExternelDocNo)
            {

            }

        }
        add(CustLedgEntry2)
        {
            column(External_Document_No_; "External Document No.")
            {

            }
        }
        add(DtldCustLedgEntries)
        {
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {

            }
        }

    }


    rendering
    {
        layout(D360CustomerStatment)
        {
            Type = RDLC;
            LayoutFile = 'D360CustomerStatment.rdl';
        }
    }
    var
        ExternelDocNo: Text;
}