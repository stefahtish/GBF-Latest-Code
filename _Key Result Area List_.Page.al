page 51112 "Key Result Area List"
{
    Caption = 'Key Result Area List';
    PageType = List;
    CardPageId = "Key result Area Card";
    SourceTable = "Key Result Area";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
