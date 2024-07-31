page 50436 "Base Calender Card New"
{
    PageType = Card;
    SourceTable = "Base Calender Custom";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Customized Changes Exist"; Rec."Customized Changes Exist")
                {
                }
            }
            part(Control6; "Base Calender Entries Subform")
            {
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Base Calender")
            {
                Caption = '&Base Calender';

                action("&Where-Used List")
                {
                    Caption = '&Where-Used List';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action("Page Base Claender Changes New")
                {
                    Caption = '&Maintain Base Calender';
                    RunObject = Page "Base Calender Changes New";
                    RunPageLink = "Base Calendar Code" = FIELD(Code);
                }
            }
        }
    }
}
