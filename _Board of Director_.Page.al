page 50518 "Board of Director"
{
    PageType = Card;
    SourceTable = "Board of Director";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(SurName; Rec.SurName)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Academic Qualifications"; Rec."Academic Qualifications")
                {
                    Caption = 'Category';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                        SetControlAppearance();
                    end;
                }
                group(Alternate)
                {
                    ShowCaption = false;
                    Visible = AlternateVisible;

                    field("Alternate Type"; Rec."Alternate Type")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = All;
                }
                field("Huduma Number"; Rec."Huduma Number")
                {
                    ApplicationArea = All;
                }
                field("Passport Number"; Rec."Passport Number")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field(Race; Rec.Race)
                {
                    ApplicationArea = All;
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    Caption = 'Ethnic Group';
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    Caption = 'Position in the Board';
                    ApplicationArea = All;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = All;
                }
            }
            group(Dates)
            {
                Caption = 'Dates';

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field(Tenure; Rec.Tenure)
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                    end;
                }
            }
            group(Reappointment)
            {
                Visible = BoardVisible;
                Enabled = false;

                field("Reappointment Start Date"; Rec."Reappointment Start Date")
                {
                    ApplicationArea = All;
                }
                field("Reappointment Tenure"; Rec."Reappointment Tenure")
                {
                    ApplicationArea = All;
                }
                field("Reappointment End Date"; Rec."Reappointment End Date")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("ReAppointment Date"; Rec."ReAppointment Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Payments)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = All;
                }
            }
            part(Education; "Applicant Job Education")
            {
                Caption = 'Academic Qualifications';
                SubPageLink = "Applicant No." = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Board Reappointment")
            {
                Visible = BoardVisible;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Board);
                    Clear(AppointmentCard);
                    AppointmentCard.SetTableView(Board);
                    // EscalationCard.LookupMode(true);                   
                    IF AppointmentCard.RUNMODAL = ACTION::OK THEN BEGIN
                        AppointmentCard.GetNewDetails(StartDate, Term, EndDate, AppointmentDate);
                        if StartDate = 0D then Error('Start date must be entered');
                        if EndDate = 0D then Error('Tenure must be entered');
                        if AppointmentDate = 0D then Error('Tenure must be entered');
                        Rec.InsertAppointmentDetails(StartDate, Term, EndDate, AppointmentDate);
                        //ClaimAssignment.EscalateIncident("Incident Reference", EscOption, EscNo, EscName, EscEmail);
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        AlternateVisible: Boolean;
        AppointmentCard: page "Board Appointment";
        Board: Record "Board of Director";
        StartDate: Date;
        Term: DateFormula;
        EndDate: Date;
        AppointmentDate: Date;
        BoardVisible: Boolean;

    local procedure SetControlAppearance()
    begin
        if Rec."Academic Qualifications" = Rec."Academic Qualifications"::Alternate then
            AlternateVisible := true
        else
            AlternateVisible := false;
        if (Rec."Appointment Date" <> 0D) then
            BoardVisible := true
        else
            BoardVisible := false;
    end;
}
