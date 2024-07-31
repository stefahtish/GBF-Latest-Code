page 50967 "Testing Resource Alloc. List"
{
    Caption = 'Testing resource allocation list';
    CardPageId = "Testing Resource Allocation";
    PageType = List;
    SourceTable = "Testing Resorce Allocation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(AllocationNo; Rec.AllocationNo)
                {
                    ApplicationArea = All;
                }
                field("Nature of testing"; Rec."Nature of testing")
                {
                    Caption = 'Test Category';
                    ApplicationArea = All;
                }
                field("Testing date"; Rec."Testing date")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Market; Rec.Market)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
