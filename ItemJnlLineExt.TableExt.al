tableextension 50126 ItemJnlLineExt extends "Item Journal Line"
{
    fields
    {
        field(50000; Narration; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open, Pending, Released, Rejected;
        }
    }
    procedure Post()
    begin
        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", Rec);
    end;
}
