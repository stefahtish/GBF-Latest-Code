page 50702 "Board Appointment"
{
    Caption = 'Board Appointment';
    PageType = Card;
    SourceTable = "Board of Director";
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
                    Enabled = false;
                }
                field(StartDate; StartDate)
                {
                }
                field(Term; Term)
                {
                    trigger OnValidate()
                    begin
                        EndDate := CalcDate(Term, StartDate);
                    end;
                }
                field(EndDate; EndDate)
                {
                    Enabled = false;
                }
                field(AppointmentDate; AppointmentDate)
                {
                }
            }
        }
    }
    var
        StartDate: Date;
        Term: DateFormula;
        EndDate: Date;
        AppointmentDate: Date;

    procedure GetNewDetails(var StartD: Date; var Tenure: DateFormula; var EndD: Date; var AppDate: Date)
    begin
        StartD := StartDate;
        Tenure := Term;
        EndD := EndDate;
        AppDate := AppointmentDate;
    end;
}
