page 51113 "Key result Area Card"
{
    Caption = 'Key result Area Card';
    PageType = Card;
    SourceTable = "Key Result Area";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
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
            part("Strategic Issues"; "Strategic Issues")
            {
                SubPageLink = "KRA Code" = field(Code);
            }
        }
    }
}
