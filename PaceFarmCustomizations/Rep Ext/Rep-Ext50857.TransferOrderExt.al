reportextension 50857 TransferOrderExt extends "Transfer Order"
{
    dataset
    {

        modify("Transfer Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                Item: Record Item;
            begin
                Clear(ItemPickCode);
                If Item.get("Item No.") then
                    ItemPickCode := Item."Pick Code";
            end;
        }
        add("Transfer Line")
        {
            column(Pick_Code; ItemPickCode)
            {

            }
        }
    }

    rendering
    {
        layout(D360TransferOrder)
        {
            Type = RDLC;
            LayoutFile = 'D360TransferOrder.rdl';
        }
    }
    var
        ItemPickCode: Code[20];
}