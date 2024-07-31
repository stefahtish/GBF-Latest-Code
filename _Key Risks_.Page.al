page 51405 "Key Risks"
{
    PageType = ListPart;
    Caption = 'Key Risks That May Affect Project';
    SourceTable = "Keyrisks";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Key Risks"; Rec."Key Risks")
                {
                    ToolTip = 'Specifies the value of the Key Risks field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
