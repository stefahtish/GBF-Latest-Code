page 51016 "Reasons for Confiscation Setup"
{
    Caption = 'Reasons for Confiscation';
    PageType = List;
    SourceTable = "Reasons For Confiscation Setup";
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
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Reasons)
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Confisc Reasons";
                RunPageLink = Code = field(Code);
            }
        }
    }
}
