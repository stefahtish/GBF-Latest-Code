page 51114 "Strategic Issues"
{
    Caption = 'Strategic Issues';
    PageType = ListPart;
    SourceTable = "Strategic Issue";
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
                field("KRA Code"; Rec."KRA Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Strategic objectives")
            {
                Image = Process;
                RunObject = page "Strategic Objective";
                RunPageLink = "KRA Code" = field("KRA Code"), "Issue Code" = field(Code);
            }
        }
    }
}
