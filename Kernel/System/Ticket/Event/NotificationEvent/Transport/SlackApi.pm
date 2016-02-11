
package Kernel::System::Ticket::Event::NotificationEvent::Transport::SlackApi;


use Moose;
use URI;
use LWP::UserAgent;
use Kernel::System::VariableCheck qw(:all);

use base qw(Kernel::System::Ticket::Event::NotificationEvent::Transport::Base);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::SystemAddress',
    'Kernel::System::Ticket',
    'Kernel::System::User',
    'Kernel::System::Web::Request',
);

=head1 NAME

Kernel::System::Ticket::Event::NotificationEvent::Transport::SlackApi - slack api transport layer

=head1 SYNOPSIS

Notification event transport layer.

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()

create a notification transport object. Do not use it directly, instead use:

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new('');
    my $TransportObject = $Kernel::OM->Get('Kernel::System::Ticket::Event::NotificationEvent::Transport::SlackApi');

=cut

has 'ua' => (
    is      => 'ro',
    isa     => 'LWP::UserAgent',
    builder => '_build_ua',
);

has 'base_url'  => (
    is       => 'ro',
    isa      => 'Str',
    default  => 'https://hooks.slack.com/services/',
);

sub _build_ua {
    return LWP::UserAgent->new( timeout => 300 );
}


sub SendNotification {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(TicketID UserID Notification)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Need $Needed!',
            );
            return;
        }
    }
    my $identical_team = 'xxxxx/xxxxx';
    $url = $self->base_url.$identical_team;
    my $uri = URI->new($url);
    #tempolary message
    $message = 'data about event';
    $self->ua->post($uri, 'payload' => $message);
    # cleanup event data
    $Self->{EventData} = undef;

    # get needed objects
    my $ConfigObject        = $Kernel::OM->Get('Kernel::Config');
    my $SystemAddressObject = $Kernel::OM->Get('Kernel::System::SystemAddress');



        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'info',
            Message  => $Message,
        );

    return 1;
}

1;

