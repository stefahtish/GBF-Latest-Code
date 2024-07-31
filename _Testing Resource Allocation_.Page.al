page 50964 "Testing Resource Allocation"
{
    Caption = 'Testing Resource Allocation';
    PageType = Card;
    SourceTable = "Testing Resorce Allocation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.Allocated;

                field(AllocationNo; Rec.AllocationNo)
                {
                    ApplicationArea = All;
                }
                field("Annual Schedule"; Rec."Annual Schedule")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Nature of testing"; Rec."Nature of testing")
                {
                    Caption = 'Test Category';
                    ApplicationArea = All;
                }
                field("Cluster Option"; Rec."Cluster Option")
                {
                    ApplicationArea = All;
                }
                group("Cluster Details")
                {
                    ShowCaption = false;
                    Visible = clustered;

                    field(Cluster; Rec.Cluster)
                    {
                        ApplicationArea = All;
                    }
                }
                group(AreaDetails)
                {
                    ShowCaption = false;
                    Visible = not clustered;

                    field(Branch; Rec.Branch)
                    {
                        ApplicationArea = All;
                    }
                    field(County; Rec.County)
                    {
                        ApplicationArea = All;
                    }
                    field("County Name"; Rec."County Name")
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
                    field("Testing date"; Rec."Testing date")
                    {
                        caption = 'Planned testing date';
                        ApplicationArea = All;
                    }
                }
            }
            part("Testing target products"; "Testing target products")
            {
                Caption = 'Target Products';
                SubPageLink = AllocationNo = field(AllocationNo);
            }
            part("Testing resource requirements"; "Testing resource requirements")
            {
                Caption = 'Resource Requirements';
                SubPageLink = AllocationNo = field(AllocationNo);
            }
            part("Testing Employee Allocation"; "Testing Employee Allocation")
            {
                Caption = 'Responsible Staff';
                SubPageLink = "Allocation No" = field(AllocationNo);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Submit")
            {
                Visible = not Rec.Allocated;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EmployeeAlloc: Record "Testing Employee Allocation";
                begin
                    EmployeeAlloc.SetRange("Allocation No", Rec.AllocationNo);
                    EmployeeAlloc.SetFilter("Employee No", '<>%1', '');
                    if not EmployeeAlloc.Find('-') then Error('You must specify at least one employee');
                    // LabMgmt.SendScheduleNotice2(Rec);
                    CurrPage.Close();
                    exit;
                end;
            }
            action(Reopen)
            {
                Visible = Rec.Allocated;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Allocated := false;
                    exit;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        LabMgmt: Codeunit "Laboratory Management";
        clustered: Boolean;

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        if Rec."Cluster Option" = Rec."Cluster Option"::Cluster then
            clustered := true
        else
            clustered := false;
    end;
}
