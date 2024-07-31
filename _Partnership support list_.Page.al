page 51051 "Partnership support list"
{
    Caption = 'Partnership Collaborative Activities';
    PageType = List;
    CardPageId = "Partnership support";
    SourceTable = "Partnerships Activity Plan";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Name of partnership"; Rec."Name of partnership")
                {
                    ApplicationArea = All;
                }
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(Subcounty; Rec.Subcounty)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
